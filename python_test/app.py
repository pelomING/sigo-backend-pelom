import os
from flask_cors import CORS
from dotenv import load_dotenv


from flask import Flask, request, jsonify, send_file, Response
from datetime import datetime, timedelta, timezone
from flask_jwt_extended import create_access_token, get_jwt, get_jwt_identity, \
                                unset_jwt_cookies, jwt_required, JWTManager


app = Flask(__name__)
cors = CORS(app, resources={r"/*": {"origins": "*"}})

load_dotenv()

expiracion = os.getenv('JWT_ACCESS_TOKEN_EXPIRES')
app.config["JWT_SECRET_KEY"] = os.getenv('JWT_SECRET_KEY')
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(hours=int(expiracion))
jwt = JWTManager(app)

user_ok = os.getenv('USER').upper()
password_ok = os.getenv('PASSWORD')


@app.route('/')
def index():
    return 'Buenos Dias'


@app.route('/api/test', methods=['GET'])
def test():
    print(request)
    datos = [
        {"nombre": "Pepe", "edad": 24, "ciudad": "Cordoba"},
        {"nombre": "Juan", "edad": 25, "ciudad": "Santiago"},
        {"nombre": "Maria", "edad": 26, "ciudad": "Buenos Aires"},
        {"nombre": "Luis", "edad": 27, "ciudad": "Lima"}
    ]
    response_body = datos
    return response_body


@app.route('/login', methods=['POST'])
def login():
    if not request.is_json:
        return jsonify({"msg": "Missing JSON in request"}), 400

    username = request.json.get('username', None).upper()
    password = request.json.get('password', None)
    if not username:
        return jsonify({"msg": "Missing username parameter"}), 400
    if not password:
        return jsonify({"msg": "Missing password parameter"}), 400

    if username == user_ok and password == password_ok:
        token = create_access_token(identity=username)
        authenticated = True
        response = jsonify(token=token, authenticated=authenticated)
        response.set_cookie(
            'Authorization',
            'Bearer ' + token,
            secure=True,
            max_age=3600
        )
        return response

    return jsonify({"msg": "Bad username or password"}), 401


@app.route('/logout', methods=['POST'])
def logout():
    response = jsonify({"msg": "logout successful"})
    unset_jwt_cookies(response)
    return response


@app.route('/api/valida')
@jwt_required()
def valida_token():
    print(request)
    response_body = {
        "valida": "yes"
    }
    return response_body


@app.route('/api/reporte', methods=['GET'])
@jwt_required()
def reporte():
    print(request)
    datos = [
        {"nombre": "Pepe", "edad": 24, "ciudad": "Cordoba"},
        {"nombre": "Juan", "edad": 25, "ciudad": "Santiago"},
        {"nombre": "Maria", "edad": 26, "ciudad": "Buenos Aires"},
        {"nombre": "Luis", "edad": 27, "ciudad": "Lima"}
    ]
    response_body = datos
    return response_body


@app.route('/api/formulario', methods=['POST'])
@jwt_required()
def formulario():
    codigo_proyecto = request.json.get('codigo_proyecto', None)
    tipo_proyecto = request.json.get('tipo_proyecto', None)
    valor = request.json.get('valor', None)
    fecha_ingreso = request.json.get('fecha_ingreso', None)
    print(codigo_proyecto, tipo_proyecto, valor, fecha_ingreso)
    response_body = {
        "success": True,
        "msg": "Formulario enviado correctamente",
    }
    return response_body


if __name__ == '__main__':
    app.run(debug=True)


