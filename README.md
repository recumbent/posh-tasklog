# Posh Tasklog

Powershell module to let me do very simple work logging.

Written in F# - because (-:

## Commands

* Start something - it needs a title
* Stop whatever it is I last started
* Note something, assumed to be part of whatever it is I'm working

## Plan

1. [x] Work through an example of an F# cmdlet
1. [ ] Document Start functionality
1. [x] Can I test with Pester ?? See [Pester](https://pester.dev)
   1. [x] Yes if I can set up a test drive and use it as the target for my commands
   1. [ ] This also means that I need to understand `$psdefaultparametervalues`
1. [ ] Implement test functionality
   1. [ ] Create file if missing
   1. [ ] Don't create file if it already exists (file count should be unchange, content should be persisted)
   1. [ ] Add title (same test, in both cases, its two tests)
   1. [ ] Add end task, have to do this as a #end:HH:mm tag?
   1. [ ] Add note capability, notes are plain text, so really simple
   1. [ ] Add note parameter to start
   1. [ ] Add note parameter to end (note should, for now, follow timestamp)
1. [ ] Wrap it in a module, because this is generally "better"

## Note to self...

Create Tasklog: as a PS Drive (in one's profile) in order to make life easier (ish)

Then set it as the default -TaskLogPath parameter because that really will make life easier (c.f. `$psdefaultparametervalues`)

Then how do I wire the above into profiles that I use (import the module etc) but maybe keeps some clean?

Then how do I set up to publish / install / update said module trivially (there's a build process in there somewhere)

Baby steps...

## Testing

Because I'm writing a Cmdlet I (probably) want tot use pester to do at least some testing - of an integration type nature where I'm testing calling the comdlets rather than anything where I test the internal function of the code (allowing that these are similar).

For pester to work its assumed that the test module will be in the "publish" folder off the root: `dotnet publish -o publish`

Run invoke-pester from the root, things _should_ pass. But it will lock the .dll so use `pwsh -Command invoke-pester` to wrap the import of the module into a process that goes away after the test finish.

## Usage

I can do multiline notes using here strings `@"..."@`. In theory at least, which makes this all the better really!

## References

* [Nate Lehman - Writing PowerShell Modules in F#](https://medium.com/@natelehman/writing-powershell-modules-in-f-ed52704d97ed)
* [Pester](https://pester.dev)
* [Managing Windows PowerShell Drives](https://docs.microsoft.com/en-us/powershell/scripting/samples/managing-windows-powershell-drives?view=powershell-7.1)
* 