from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "Bienvenido al proyecto DevOps educativo"

@app.route('/health')
def health():
    return "OK", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)