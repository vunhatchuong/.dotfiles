# {{_variable_}}

{{_cursor_}}

## **Table of Contents**

- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Deploy using Docker](#deploy-using-docker)
- [Development](#development)

## Overview

## Requirements

## Installation

Install dependencies using:

```bash
```

## Usage

Make a copy of `.env.template` an change it to `.env` with appropriate information.

```bash

```

## Deploy using Docker

Docker will use `.env` values for some settings.

Build the image

```bash
docker build -t {name} .
```

Run the image

```bash
docker run -p 3000:3000 {name}
# Or
docker compose -f docker-compose.yml up
```

## Development

Install development dependencies:

```bash
```
