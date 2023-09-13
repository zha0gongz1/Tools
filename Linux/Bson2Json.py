import os
import sys
import json
import bson
from datetime import datetime
from bson.objectid import ObjectId

def read_large_bson_file(filename):
    base_name = os.path.splitext(os.path.basename(filename))[0]
    output_filename = base_name + '.json'

    def json_serial(obj):
        if isinstance(obj, datetime):
            return obj.isoformat()
        if isinstance(obj, ObjectId):
            return str(obj)
        raise TypeError ("Type %s not serializable" % type(obj))

    with open(filename, 'rb') as f, open(output_filename, 'w') as out_f:
        data = bson.decode_file_iter(f)
        for doc in data:
            json.dump(doc, out_f, default=json_serial, ensure_ascii=False)
            out_f.write('\n')


if len(sys.argv) > 1:
    read_large_bson_file(sys.argv[1])
else:
    print("Please provide a BSON file name as a command line argument.")
