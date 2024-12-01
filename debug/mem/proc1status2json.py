import json
import sys

def parse_input_to_dict(input_data):
    result = {}
    string_keys = {
        "SigQ", "SigPnd", "ShdPnd", "SigBlk", "SigIgn", "SigCgt",
        "CapInh", "CapPrm", "CapEff", "CapBnd", "CapAmb"
    }
    
    for line in input_data.splitlines():
        if not line.strip():
            continue
        key, _, value = line.partition(':')
        key = key.strip()
        value = value.strip()
        
        # Convert values to appropriate types
        if key == "Umask":
            result[key] = f"0o{value}"  # Convert Umask to octal string
        elif key in string_keys:
            result[key] = value  # Keep as string
        elif key in {"Uid", "Gid"}:
            result[key] = list(map(int, value.split()))
        elif key in {"Groups"}:
            result[key] = list(map(int, value.split()))
        elif key in {"Cpus_allowed", "Mems_allowed"}:
            result[key] = int(value, 16) if value.startswith("0x") else int(value)
        elif key.startswith("Vm") and value.endswith("kB"):
            result[key] = int(value.replace("kB", "").strip())  # Remove "kB" and convert to int
        elif key.startswith("Rss") and value.endswith("kB"):
            result[key] = int(value.replace("kB", "").strip())  # Remove "kB" and convert to int
        elif key.startswith("Hugetlb") and value.endswith("kB"):
            result[key] = int(value.replace("kB", "").strip())  # Remove "kB" and convert to int
        elif value.isdigit():
            result[key] = int(value)
        elif value.replace('.', '', 1).isdigit():
            result[key] = float(value)
        else:
            result[key] = value
    
    return result

def main():
    input_data = sys.stdin.read()
    parsed_data = parse_input_to_dict(input_data)
    print(json.dumps(parsed_data, indent=4), end="")

if __name__ == "__main__":
    main()
