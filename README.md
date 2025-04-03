# BICScan MCP Server

A powerful and efficient Blockchain address risk scoring API MCP Server, leveraging the BICScan API to provide comprehensive risk assessments and asset information for blockchain addresses, domains, and decentralized applications (dApps).

🎉 We're listed on https://github.com/modelcontextprotocol/servers for official integration 🎉


https://github.com/user-attachments/assets/f9425429-1cb1-4508-b962-81351075258b

## Key Features
- **Risk Scoring**: Obtain risk scores for various blockchain entities, including crypto addresses, domain names, and decentralized application URLs, with scores ranging from 0 to 100, where 100 indicates high risk.
- **Asset Information**: Retrieve detailed asset holdings for specified crypto addresses, including cryptocurrencies and tokens, with support for multiple blockchain networks.
- **Real-time Scanning**: Utilize the BICScan API to perform real-time scans and receive up-to-date information on potential risks and asset holdings.
- **Secure and Reliable**: Built with robust error handling and logging to ensure secure and reliable operations.

## Example Output

## How to use.

You con either use Python with `uv` or `docker` depending on your preference.

Depending on your environment, you can choose to use either `uv`, `docker`, or `uvx`.

### 1. Running with `uv`

#### 1-1. Requirements
1. Python 3.10 or higher
2. uv 0.6.x
3. git

#### 1.2. Clone the repository
```sh
git clone https://github.com/ahnlabio/bicscan-mcp
```

#### 1.3. Config `claude_desktop_config.json`

Append following to `claude_desktop_config.json`.

Make sure to replace:
 - `YOUR_BICSCAN_REPO_DIR_HERE`: to something like `C:\\Users\\ABC\\repo\\bicscan-mcp` or `/home/abc/repo/bicscan-mcp` similarly.
 - `YOUR_BICSCAN_API_KEY_HERE`: to free API key can be obtained from https://bicscan.io (details below)

```json
{
  "mcpServers": {
    ... some other mcp servers ...,
    "bicscan": {
      "command": "uv",
      "args": [
        "--directory",
        "YOUR_BICSCAN_REPO_DIR_HERE",
        "run",
        "bicscan-mcp"
      ],
      "env": {
        "BICSCAN_API_KEY": "YOUR_BICSCAN_API_KEY_HERE"
      }
    }
  }
}
```

### 2. Running with `Docker`

#### 2.1. Requirements
1. Docker environment

#### 2.2. Clone the repository
```sh
git clone https://github.com/ahnlabio/bicscan-mcp
```

#### 2.3. Build Docker image.

Just run `make` in the repository directory to build docker image.

#### 2.4. Config
Append following to `claude_desktop_config.json`

Make sure to replace:
 - `YOUR_BICSCAN_API_KEY_HERE` to API key obtained from https://bicscan.io (details below)

```json
{
  "mcpServers": {
    ... some other mcp servers ...,
    "bicscan": {
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "--interactive",
        "--env", "BICSCAN_API_KEY=YOUR_BICSCAN_API_KEY_HERE",
        "bicscan-mcp"
      ]
    }
  }
}
```

### 3. Running with `uvx`

#### 3.1. Requirements
1. Python 3.10 or higher
2. uv 0.6.x
3. git

#### 3.2. Config `claude_desktop_config.json`

Append following to `claude_desktop_config.json`.

Make sure to replace:
 - `YOUR_BICSCAN_API_KEY_HERE`: to free API key can be obtained from https://bicscan.io (details below)

```json
{
  "mcpServers": {
    ... some other mcp servers ...,
    "bicscan": {
      "command": "uvx",
      "args": [
        "--from",
        "git+https://github.com/ahnlabio/bicscan-mcp",
        "bicscan-mcp"
      ],
      "env": {
        "BICSCAN_API_KEY": "YOUR_BICSCAN_API_KEY_HERE"
      }
    }
  }
}
```

## How to obtain Free BICScan API Key?

1. Visit `https://bicscan.io` and register.
2. Go to profile and create "Create App"
3. Enter name and description on your choice.
4. Replace `YOUR_BICSCAN_API_KEY_HERE` part from above config to your newly obtained key.
5. restart the Claude Desktop.
