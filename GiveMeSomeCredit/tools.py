import json
from os.path import exists


def json_save_project(data, project, version):
    json_filename = project + '-' + version + '.json'
    json.dump(data, open(json_filename, "w"))


def json_load_project(project, version):
    json_filename = project + '-' + version + '.json'
    if exists(json_filename):
        data = json.load(open(json_filename, "r"))
        return data
    return {}
