# Chatapp

A Flask chat application that streams responses from an Ollama language model and
saves conversation history in MySQL or MariaDB. On the course server, Nginx serves
it at `/viikko5/` and forwards requests to Gunicorn over a Unix socket.

## Run locally

You need Python 3.12+ and [Ollama](https://ollama.com/). From the repository root:

```bash
cd viikko5
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
ollama pull qwen2.5:0.5b
OLLAMA_MODEL=qwen2.5:0.5b flask --app app run
```

Open <http://127.0.0.1:5000/>. Start Ollama first if it is not already running.
Without database environment variables, chat history is kept in memory and is
lost when the app restarts.

Run tests and checks from the repository root:

```bash
pip install -r viikko5/requirements-dev.txt
pytest viikko5
ruff check viikko5
```

## Deploy to the course server

The setup and deployment scripts target the existing Ubuntu/cPouta server. It
needs a public IP with HTTP port 80 open, Nginx already serving the other course
pages, and a deployment user with SSH and passwordless `sudo`. Use the writable
database server, not a read-only replica.

### First-time server setup

Copy or clone the repository onto the server. From its root, run:

```bash
bash viikko5/scripts/server-setup.sh qwen2.5:0.5b
```

Choose a model appropriate for the server's memory. The script installs required
packages and Ollama, prepares the database and app user, and creates
`/etc/chatapp/chatapp.env` with generated database credentials.

Add this line once inside the existing Nginx `server { ... }` block (usually
`/etc/nginx/sites-available/default`):

```nginx
include snippets/chatapp.conf;
```

Then check and reload Nginx:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

### Deploy updates

**Automatic:** Add these GitHub Actions secrets to the `production` environment:

- `CPOUTA_HOST` - server IP or hostname
- `CPOUTA_USER` - SSH deployment user
- `CPOUTA_SSH_KEY` - that user's private SSH key
- `CPOUTA_KNOWN_HOSTS` - optional verified host-key entry

Push to `main`. The workflow runs tests and deploys if they pass. Pull requests
run checks but do not deploy. If `CPOUTA_KNOWN_HOSTS` is not set, the workflow
uses `ssh-keyscan`.

**Manual:** From the repository root, copy the app files and run the deploy
script (replace the user and server):

```bash
rsync -az viikko5/ DEPLOY_USER@SERVER:/opt/chatapp/app/
ssh DEPLOY_USER@SERVER 'bash /opt/chatapp/app/scripts/deploy.sh manual'
```

The app is then available at `http://SERVER/viikko5/`.

## Troubleshooting

```bash
sudo systemctl status chatapp
sudo journalctl -u chatapp -n 100 --no-pager
sudo nginx -t
```

If deployment reports a missing Nginx include, add the include line above and
rerun deployment. The deploy script checks Nginx configuration and the app's
health before reporting success.
