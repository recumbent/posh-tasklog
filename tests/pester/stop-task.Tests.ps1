BeforeAll {
    Import-Module .\publish\posh-tasklog.dll
}

Describe "stop-task" {
    Context "No file for today" {

        BeforeAll {
            # Arrange 
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName

            $initialCount = Get-ChildItem "TestDrive:\" | Measure-Object | Select-Object -ExpandProperty Count  
           
            # Act
            Stop-task -TasklogPath "TestDrive:\"
        }

        It "Should not create a file" {
            $currentCount = Get-ChildItem "TestDrive:\" | measure-object | Select-Object -ExpandProperty Count

            $path | Should -Not -Exist
            $currentCount | Should -Be $initialCount
        }
    }

    Context "File for today" {
        BeforeAll {
            # Arrange 
            $date = Get-Date -Format "yyyy-MM-dd"
            $timestamp = Get-Date -Format "HH:mm"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName
            
            $content = @"
# Task log for 03-Apr-2021

## 12:34 - Something started

"@
            
            $content | out-file -FilePath $path -Encoding utf8

            $initialCount = Get-ChildItem "TestDrive:\" | Measure-Object | Select-Object -ExpandProperty Count
        }

        It "Should not add a new file" {
            $currentCount = Get-ChildItem "TestDrive:\" | Measure-Object | Select-Object -ExpandProperty Count  

            $currentCount | Should -Be $initialCount
        }

        It "Should cotain a timestamped end" {
            $expected = "#end: $timestamp"
            $path | Should -FileContentMatch $expected
        }
    }
}