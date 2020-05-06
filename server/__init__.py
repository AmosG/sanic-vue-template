from pathlib import Path
from datetime import datetime, timedelta

from sanic import Sanic, response
from sanic.request import Request as _Request
from sanic.exceptions import NotFound
from sanic.log import logger

from server.healthcheck import HealthCheck, EnvironmentDump
from .config import Config
from .api_v1 import api_bp


class Request(_Request):
    user = None


app = Sanic(__name__, request_class=Request)
app.config.from_object(config)

health = HealthCheck(app, "/healthcheck")
envdump = EnvironmentDump(app, "/environment")


logger.info(f'>>> Current env:{Config.SANIC_ENV} DEBUG:{Config.DEBUG}')
app.static('/static', Config.DIST_DIR+'/static')
app.static('/favicon.ico', Config.DIST_DIR+'/favicon.ico')

app.blueprint(api_bp)


@app.exception(NotFound)
async def ignore_404s(request, exception):
    return response.text("404. Oops, That page couldn't found.")


async def server_error_handler(request, exception):
    return response.text('Oops, Sanic Server Error! Please contact the blog owner',
                         status=500)


# serve index.html, built by Vue-CLI
@app.route('/')
async def handle_request(request):
    return await response.file(Config.DIST_DIR+'/index.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=Config.DEBUG)
