BeforeAll {
    Import-Module .\publish\posh-tasklog.dll
}

Describe "start-task" {
    It "Start something should create a file if it doesn't exist" {
        
        $date = Get-Date -Format "yyyy-MM-dd"
        $taskLogFileName = $date + ".md"
        $path = "TestDrive:\" + $taskLogFileName
        
        Start-task -TasklogPath "TestDrive:\" "A test task title"
        
        $path | Should -Exist
    }
}
