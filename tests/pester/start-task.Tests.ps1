BeforeAll {
    Import-Module .\publish\posh-tasklog.dll
}

Describe "start-task" {
    Context "No file for today" {

        BeforeAll {
            # This is the arrange and "act" for the tests...
            Start-task -TasklogPath "TestDrive:\" "A test task title"
        }
        
        It "Should create a file" {
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName
                
            $path | Should -Exist
        }
        
        It "Should write a title to the file" {
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName

            $path | Should -FileContentMatch "# Task log for"
        }
    }
}
