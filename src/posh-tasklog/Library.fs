namespace PoshTasklog

open System
open System.IO
open System.Management.Automation



    
[<Cmdlet("Start", "Task")>]
type GetFooCommand () =
    inherit PSCmdlet ()

    let makeTaskFilePath (cmdlet : PSCmdlet) rootPath (date : DateTime) =
        let formattedDate  = date.ToString("yyyy-MM-dd")
        let fileName = $"{formattedDate}.md"
        let psPath = Path.Join(rootPath, fileName)
        cmdlet.GetUnresolvedProviderPathFromPSPath psPath

    let formatTitle (taskDate : DateTime) =
        // The title can be more human friendly than the filename
        let formattedDate = taskDate.ToString("dd-MMM-yyyy")
        $"# Task Log for {formattedDate}/n"

    [<Parameter>]
    member val TaskLogPath : string = "" with get, set

    [<Parameter(Position=0, Mandatory=true)>]
    member val Title : string = "" with get, set

    override cmdlet.ProcessRecord () =
        let taskDate = DateTime.Today
        let filePath = makeTaskFilePath cmdlet cmdlet.TaskLogPath taskDate
        let info = FileInfo filePath
        if not info.Exists then
            cmdlet.WriteInformation("Creating tast file", [||])
            let fileTitle = formatTitle taskDate
            File.WriteAllText(filePath, fileTitle)
        
        ()
