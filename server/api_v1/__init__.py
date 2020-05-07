""" API Blueprint Application """

from sanic import Blueprint, response

# --> '/api/v1/'
api_bp = Blueprint('api_bp_v1', url_prefix='/api/v1')

# Import resources to ensure view is registered
from .resources import *

