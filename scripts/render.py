#!/usr/bin/env python3

import glob
import re
import sys
import os
import webbrowser
import argparse
from jinja2 import Template

parser = argparse.ArgumentParser()
parser.add_argument("-g", dest='google_analytics', help='Google Analtics UA (eg. UA-XXXXXXXX-Y)')
args = parser.parse_args()

if not args.google_analytics:
    print('Warning: No Google analytics tracking code will be used')
    
this_dir = os.path.dirname(__file__)
template_file = os.path.join(this_dir, 'index.html.tpl')

# used to sort tiles
extract_int = lambda item: int(re.search('.+_(\d+)\..+', item).groups()[0])

template = Template(open(template_file).read())
images = sorted(glob.glob(os.path.join(this_dir, '..', 'tiles/*.jpg')), key=extract_int)
images = [os.path.basename(i) for i in images]
dest_file = os.path.realpath(os.path.join(this_dir, '..', 'index.html'))
open(dest_file, 'w').write(template.render(images=images, google_analytics=args.google_analytics))
print("Wrote {}".format(dest_file))
