import os
from server import app, Config

app.run(host='0.0.0.0', port=5000, debug=Config.DEBUG)

# To Run:
# python run.py
