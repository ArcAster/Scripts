#!/bin/bash
# script to install elixir / erlang on Ubuntu 16.04 + 18.04 lts
#
#
#

echo "Import Erlang-Solutions GPG key..."
wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -

echo "Add Erlang-Solutions ERL Repository..."
echo "deb https://packages.erlang-solutions.com/ubuntu bionic contrib" | sudo tee /etc/apt/sources.list.d/rabbitmq.list

echo "Install Erlang"
sudo apt update
sudo apt -y install erlang

echo "Installing Elixir"
sudo apt -y install elixir

echo "Finshed Installing Erlang and Elixir"
echo "To verify ERLANG install try > $ erl"
echo "To verify ELIXIR install try > $ iex"
