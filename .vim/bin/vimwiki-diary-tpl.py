#!/usr/bin/env python3

import sys
from datetime import datetime, timedelta
from pathlib import Path

template = """= {date} =
 
== Daily checklist | recur:daily due:{today} ==

== Overdue | project:Work due.before:{today} status.not:completed ==
 
== Todo | project:Work due:{today} status.not:completed ==
* [ ]

=== Done | project:Work end.after:{today} and end.before:{tomorrow} status:completed ===
 
== Home tasks | project:Home status.not:completed ==

== Notes == """

# default
#
dt = datetime.today()
if len(sys.argv) > 1:
    fp = Path(sys.argv[1])
    dt = datetime.strptime(fp.stem, "%Y-%m-%d")

today = dt
tomorrow = dt + timedelta(days=1)


print(
    template.format(
        date=today.strftime("%b %d, %Y"),
        today=today.strftime("%Y-%m-%d"),
        tomorrow=tomorrow.strftime("%Y-%m-%d"),
    )
)
