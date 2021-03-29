import csv
import gzip
import json
import os

TABLES = ['orders', 'playlist_track', 'track_facts', 'tracks']

def json_reader(filename):
    """
    This function converts a file of json objects to a list of dicts
    :param filename: file to be read from
    :return: list of dicts
    """
    json_data = []
    with open(filename) as f:
        for line in f:
            raw_data = json.loads(line)

            if len(raw_data) != 0:
                json_data.append(raw_data)

    return json_data


if __name__ == "__main__":
    raw_data_path = "../raw_data/"

    for table in TABLES:
        all_records = []
        table_path = f"{raw_data_path}{table}/"

        # Check if file is CSV or JSON, add all rows in the file to all_records list
        for filename in os.listdir(table_path):
            full_file_name = os.path.join(table_path, filename)

            if filename.endswith(".csv"):
                csv_dict_data = list(csv.DictReader(open(full_file_name)))
                all_records = all_records + csv_dict_data

            if filename.endswith(".json"):
                json_dict_data = json_reader(full_file_name)
                all_records = all_records + json_dict_data

        # Write all_records to a compressed JSON file
        with gzip.open(f"../processed_data/{table}.json.gz",
                       "wt",
                       encoding="ascii") as zipfile:
            json.dump(all_records, zipfile)

        print(f"Processed all {table} files")
