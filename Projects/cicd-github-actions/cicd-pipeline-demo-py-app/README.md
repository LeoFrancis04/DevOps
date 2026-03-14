# Basic CI/CD Pipeline Demo (Python)

This project demonstrates a foundational Continuous Integration and Continuous Deployment (CI/CD) pipeline using GitHub Actions, tailored for a monorepo structure.

## 🚀 Overview
The pipeline automatically tests Python code on every push and simulates a deployment process. It acts as a quality gate, ensuring that broken code cannot reach the simulated production environment.

## 🛠️ Tech Stack
* **Language:** Python 3.10
* **Package Manager:** `uv` (for ultra-fast dependency resolution and installation)
* **Testing Framework:** `pytest`
* **CI/CD Platform:** GitHub Actions

## ⚙️ Pipeline Architecture
The workflow (`.github/workflows/python-ci.yml`) is split into two sequential jobs:

1. **`build-and-test`**:
   * Provisions a fresh Ubuntu runner.
   * Installs Python and `uv`.
   * Installs dependencies globally using `uv pip install --system`.
   * Executes unit tests via `pytest`.
2. **`deploy`**:
   * Uses the `needs: build-and-test` directive to ensure it only runs if the testing job passes.
   * Simulates a production deployment via shell commands.

*Note: This pipeline utilizes path filtering (`paths:`), meaning it only triggers when files within this specific project directory are modified, making it ideal for monorepo environments.*

## 💻 Running Locally
To test the application locally before pushing:

```bash
# Create and activate a virtual environment
uv venv
source .venv/bin/activate

# Install dependencies
uv pip install pytest

# Run the tests
pytest -v