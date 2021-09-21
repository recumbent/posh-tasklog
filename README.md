# Posh Tasklog

Powershell module to let me do very simple work logging.

Written in F# - because (-:

## Commands

* Start something - it needs a title
* Stop - whatever it is I last started
* Note something - assumed to be part of whatever it is I'm working, timestamp might be good, need option to not have timestamp (not sure what the default should be)

## Plan

1. [x] Work through an example of an F# cmdlet
1. [ ] Document Start-task functionality
1. [ ] Document Stop-task functionality
1. [ ] Document Add-TaskNote functionality
1. [x] Can I test with Pester ?? See [Pester](https://pester.dev)
   1. [x] Yes if I can set up a test drive and use it as the target for my commands
   1. [ ] This also means that I need to understand `$psdefaultparametervalues` because if I'm requiring a target folder I don't want to have to type it every time
1. [ ] Implement test functionality
   1. [x] Create file if missing
   1. [x] Don't create file if it already exists (file count should be unchange, content should be persisted)
   1. [x] Add title (same test, in both cases, its two tests)
   1. [ ] Add stop task, have to do this as a #end:HH:mm tag?
      1. [x]  Does not create a file if no file found
      1. [ ]  Returns a warning if no file found
      1. [x]  Assumes there is an active task (for simplicity, may change later) so will always work
      1. [x]  Lets add an HR after, because...
   1. [x] Add note capability, notes are plain text, so really simple
   1. [ ] Add note parameter to start
   1. [ ] Add note parameter to end (note should, for now, follow timestamp)
1. [ ] Use verbs from library properly if you're not already
1. [ ] Wrap it in a module, because this is generally "better"
1. [ ] How can I publish for personal use? (Installable, updateable)
1. [ ] More formatting or other hints to let me parse things after the fact
   1. 
1. [ ] Some idiot proofing so that I get a sane log
   1. [ ] Can only end something that started
   1. [ ] Add the HR (separator) on start of next not end of current
1. [ ] Reporting, of a sort
1. [ ] Bonus projects:
   1. [ ] Can I wire it into teams calls, especially where someone calls me
   1. [ ] Can I create a teams both with the same logic (and ideally the same target via onedrive)
1. [ ] Did I mention more structure/formatting? Something consistent with the todo list, that I also need to make work

## Note to self...

Create Tasklog: as a PS Drive (in one's profile) in order to make life easier (ish)

Then set it as the default -TaskLogPath parameter because that really will make life easier (c.f. [`$psdefaultparametervalues`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_parameters_default_values?view=powershell-7.1))

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