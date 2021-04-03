namespace PoshTasklog

open System
open System.IO
open System.Management.Automation

module Helpers =
    let makeTaskFilePath (cmdlet : PSCmdlet) rootPath (date : DateTime) =
        let formattedDate  = date.ToString("yyyy-MM-dd")
        let fileName = $"{formattedDate}.md"
        let psPath = Path.Join(rootPath, fileName)
        cmdlet.GetUnresolvedProviderPathFromPSPath psPath
   
[<Cmdlet("Start", "Task")>]
type StartTaskCommand () =
    inherit PSCmdlet ()

    let formatTitle (taskDate : DateTime) =
        // The title can be more human friendly than the filename
        let formattedDate = taskDate.ToString("dd-MMM-yyyy")
        $"# Task Log for {formattedDate}"

    [<Parameter>]
    member val TaskLogPath : string = "" with get, set

    [<Parameter(Position=0, Mandatory=true)>]
    member val Title : string = "" with get, set

    override cmdlet.ProcessRecord () =
        let timestamp = DateTime.Now
        let taskDate = timestamp.Date
        
        let filePath = Helpers.makeTaskFilePath cmdlet cmdlet.TaskLogPath taskDate
        let info = FileInfo filePath
        if not info.Exists then
            cmdlet.WriteInformation("Creating task file", [||])
            let fileTitle = formatTitle taskDate
            File.WriteAllLines(filePath, [ fileTitle; String.Empty ])
    
        let formattedTime = timestamp.ToString("HH:mm")
        let taskHeading = $"## {formattedTime} - {cmdlet.Title}"
        File.AppendAllLines(filePath, [ taskHeading; String.Empty ])
        ()

[<Cmdlet("Stop", "Task")>]
type StopTaskCommand () =
    inherit PSCmdlet ()

    [<Parameter>]
    member val TaskLogPath : string = "" with get, set

    override cmdlet.ProcessRecord () =
        let timestamp = DateTime.Now
        let taskDate = timestamp.Date
        
        let filePath = Helpers.makeTaskFilePath cmdlet cmdlet.TaskLogPath taskDate
        let info = FileInfo filePath
        if info.Exists then
            let formattedTime = timestamp.ToString("HH:mm")
            let endEntry = $"#end: {formattedTime}"
            File.AppendAllLines(filePath, [ endEntry; String.Empty ])

        ()