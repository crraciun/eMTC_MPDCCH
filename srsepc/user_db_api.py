from flask import jsonify

def predict() :    
    json_ = request.json
    new = pd.read_csv('user_db.csv')
    json_vector = new.transform(json_)
    query = pd.DataFrame(json_vector)
    prediction = regr.predict(query)
    data = {'IMSI': list({{IMSI}})}
    return jsonify(data)
