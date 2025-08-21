import pickle

def deserialize_user(serialized_data):
    # Insecure deserialization vulnerability
    return pickle.loads(serialized_data.encode('latin1'))
