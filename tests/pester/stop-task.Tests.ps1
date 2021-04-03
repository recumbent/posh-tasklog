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
            $timestamp = Get-Date -Format "HH:mm"

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
}