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
            Start-Task -TasklogPath "TestDrive:\" $task
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

    Context "File already exists" {

        BeforeAll {
            # Arrange 
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName
            $task = "A test task title"
            $timestamp = Get-Date -Format "HH:mm"
            
            $random = New-Guid
            $content = @"
# This is a test file so deliberately wrong

Random content: $random

"@

            $content | out-file -FilePath $path -Encoding utf8
            
            # Act
            Start-Task -TasklogPath "TestDrive:\" $task
        }
        
        It "Should not create a file" {
            # Bit hacky, assert that there should be exactly one file because we already created one and we don't want to have created a second
            Get-ChildItem -file "TestDrive:\" | Should -HaveCount 1
        }
        
        It "Should contain existing content" {
            $path | Should -FileContentMatchMultiline "$content"
        }
        
        It "Should contain a timestamped start heading" {
            $expected = "## $timestamp - $task"
            $path | Should -FileContentMatch $expected
        }
        
        AfterAll {
            Get-Content $path | Write-Host
        }
    }
}
