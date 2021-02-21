# Posh Tasklog

Powershell module to let me do very simple work logging.

Written in F# - because (-:

## Commands

* Start something - it needs a title
* Stop whatever it is I last started
* Note something, assumed to be part of whatever it is I'm working

## Plan

1. [x] Work through an example of an F# cmdlet
1. [ ] Document Start funcitonality
1. [x] Can I test with Pester ?? See [Pester](https://pester.dev)
   1. [ ] Yes if I can set up a test drive and use it as the target for my commands
   1. [ ] This also means that I need to understand `$psdefaultparametervalues`
1. Implement test functionality
1. Wrap it in a module, because this is generally "better"

## Testing

Because I'm writing a Cmdlet I (probably) want tot use pester to do at least some testing - of an integration type nature where I'm testing calling the comdlets rather than anything where I test the internal function of the code (allowing that these are similar).

For pester to work its assumed that the test module will be in the "publish" folder off the root.

Run invoke-pester from the root, things _should_ pass

## References

* [Nate Lehman - Writing PowerShell Modules in F#](https://medium.com/@natelehman/writing-powershell-modules-in-f-ed52704d97ed)
* [Pester](https://pester.dev)
* 