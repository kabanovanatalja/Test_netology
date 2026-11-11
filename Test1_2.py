from itertools import groupby

def run_length_encode(s):
    result = []
    for char, group in groupby(s):
        count = sum(1 for _ in group)
        result.append(char + (str(count) if count > 1 else ""))
    return "".join(result)