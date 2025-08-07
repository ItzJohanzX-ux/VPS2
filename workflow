name: Deploy to VPS

on:
  push:
    branches:
      - main  # Or your main branch

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Set up SSH key
        uses: webfactory/ssh-agent@v0.7.0
        with:
          ssh-private-key: ${{ secrets.SSH_PRIVATE_KEY }}

      - name: Add known host
        run: ssh-keyscan -H ${{ secrets.VPS_HOST }} >> ~/.ssh/known_hosts

      - name: Deploy changes
        run: |
          ssh user@${{ secrets.VPS_HOST }} '
            # Example commands to deploy your application
            cd /path/to/your/application
            git pull origin main
            # Restart your application or services
            sudo systemctl restart your-application
          '
