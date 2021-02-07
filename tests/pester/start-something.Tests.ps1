BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "start-something" {
    It "Returns expected output" {
        start-something | Should -Be "YOUR_EXPECTED_VALUE"
    }
}
