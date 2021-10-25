

# YMMV - additional tools I used in demos or in prep
sudo apt-get install -y \
  bat \
  jq \
  tree \
  silversearcher-ag \
  fzf \
  tldr \
  zsh

# dive - image diffs
DIVE_VERSION="0.10.0"
wget https://github.com/wagoodman/dive/releases/download/v${DIVE_VERSION}/dive_${DIVE_VERSION}_linux_amd64.deb
sudo apt install -y ./dive_${DIVE_VERSION}_linux_amd64.deb
# rm ./dive_${DIVE_VERSION}_linux_amd64.deb