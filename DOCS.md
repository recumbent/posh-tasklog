# Murph's posh tasklog

I find myself struggling to keep track of what I've done and how long I've spent, this is an experiment in minimalist tracking via the command line, in an attempt to help keep me on track

One can reduce tracking to just two things:

1. Start a task
1. Stop the current task

In both cases we want a timestamp, and that's pretty much it. I'd also probably quite like the ability to add longer notes.

The output should be a file per day, well structured - that can be read "as is" or possibly further processed.

To keep things simple and self contained, the log file will be a markdown formatted text in a folder. Might contemplate complications (different back end/storgae) if I can make the basics work

The tooling will be implemented as powershell cmdlets (implemented in F#, but that's not really relevant). 

## Start-Task

```powershell
ps> Start-Task "This is a new task"
```

If a log file does not exist for the current date it will create one. The file will be in a designated location and the file name will be of the form yyyy-MM-dd.md e.g. 2021-07-10.md for 10th July 2021.

The log file will have a header that contains the date (format TBA) - this will be an h1

Starting a task will write a header - h2 - starting with a timestamp !start:HH:mm and then the task title (a required parameter for the cmdlet). If (when) one adds notes those will be a paragraph below the header (because its powershell its possible use a powershell here string @"..."@ over multiple lines).

For extra credit should probably write an end tag in.

Not sure about `!start:` I need to use something to delimit the tags, don't want to use @ or + because those are used for "context" and "project" in todo.txt and I'd like to be vaguely compatible. Various things use #xxx as a tag in VS Code and these aren't tags in that sense so again probably better to avoid... I'll try it and see!

## Stop-Task

```powershell
ps> Stop-Task
```

Will put a timestamp in, !end:HH:mm - ideally only if there's an active task. Should also allow a note.

## Add-TaskNote

Append an arbitrary string into the file, assumed to apply to the current task

## Interrupt - nice to have post release

Not sure, but something to handle this might be nice. Basically start task with an extra !interruption - be nice to have a resume... that does potentially get a bit funky?

Start-Task -interrupt

Start-Task -resume