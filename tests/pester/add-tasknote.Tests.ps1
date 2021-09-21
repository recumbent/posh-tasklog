BeforeAll {
    Import-Module .\publish\posh-tasklog.dll
}

Describe "add-tasknote" {
    Context "No file for today" {

        BeforeAll {
            # Arrange 
            $date = Get-Date -Format "yyyy-MM-dd"
            $taskLogFileName = $date + ".md"
            $path = "TestDrive:\" + $taskLogFileName

            $initialCount = Get-ChildItem "TestDrive:\" | Measure-Object | Select-Object -ExpandProperty Count  
           
            # Act
            Add-TaskNote "This is a note that should not get saved" -TasklogPath "TestDrive:\"
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

            # Act
            Add-TaskNote "This is a task note" -TasklogPath "TestDrive:\"
        }

        It "Should not add a new file" {
            $currentCount = Get-ChildItem "TestDrive:\" | Measure-Object | Select-Object -ExpandProperty Count  

            $currentCount | Should -Be $initialCount
        }

        It "Should contain the note text" {
            $expected = "This is a task note"
            $path | Should -FileContentMatch $expected
        }

        AfterAll {
            Get-Content $path | Write-Host
        }
    }
}