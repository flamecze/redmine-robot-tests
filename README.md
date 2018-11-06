# Redmine

## Project setup in VMware Horizon Client

- Go to H:
- Right click -> Git Bash here
- Clone repository:
```bash
git clone https://github.com/flamecze/redmine-robot-tests.git
```

- File -> Open Projects from File System...
- Select cloned directory, e.g. `H:\redmine-robot-tests`
- ...
- Profit

### Git integration

- Window -> Perspective -> Open Perspective -> Other.. -> Git

## Running tests

```bash
robot Tests/*.robot
```