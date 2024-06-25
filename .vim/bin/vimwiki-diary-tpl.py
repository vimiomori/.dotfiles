#!/usr/bin/env python3

import sys
from datetime import datetime
from pathlib import Path

template = """= {date} =
 
== Daily checklist | recur:daily due:today ==

== Overdue | project:Work +OVERDUE ==
 
== Todo | project:Work due:today ==
 
== Home tasks | project:Home ==

== Notes == """

# default
#
dt = datetime.today()
if len(sys.argv) > 1:
    fp = Path(sys.argv[1])
    dt = datetime.strptime(fp.stem, "%Y-%m-%d")


print(template.format(date=dt.strftime("%b %d, %Y")))
