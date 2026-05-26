##CPU USAGE

***top -bn1 | grep "Cpu(s)" | awk '{print "CPU: " $2 "%"}'***

```
    top -bn1
│
├── top    → shows running processes and system stats
├── -b     → batch mode — runs top non-interactively
│            without -b, top opens as live screen
│            with -b, top prints output and exits
└── -n1    → run only 1 iteration then stop
             without -n1, top keeps refreshing forever

output looks like:
%Cpu(s):  5.2 us,  1.3 sy,  0.0 ni, 92.8 id
```

```
| grep "Cpu(s)"
│
└── filters only the CPU line from top output
    ignores all other lines like process list, memory etc
    we only want the line that has CPU stats
```

```
| awk '{print "CPU: " $2 "%"}'
│
├── awk    → text processing tool, splits line into fields
├── $2     → second field of that line
│            %Cpu(s):  5.2 us ...
│            $1 = %Cpu(s):
│            $2 = 5.2      ← this is user CPU usage
│            $3 = us
└── print  → prints "CPU: 5.2%"
```