BeforeAll {
    Import-Module .\publish\posh-tasklog.dll
}

Describe "start-task" {
    Context "No file for today" {

        BeforeAll {
            # Arrange 
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName
            $task = "A test task title"
            $timestamp = Get-Date -Format "HH:mm"
            
            # Act
            Start-task -TasklogPath "TestDrive:\" $task
        }
        
        It "Should create a file" {
            $path | Should -Exist
        }
        
        It "Should write a title to the file" {
            $path | Should -FileContentMatch "# Task log for"
        }
        
        It "Should contain a timestamped start heading" {
            $expected = "## $timestamp - $task"
            $path | Should -FileContentMatch $expected
        }
    }
}
