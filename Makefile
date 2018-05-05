apt-install:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade
	sudo apt-get remove xul-ext-ubufox gedit
	sudo apt-get install gnome-tweak-tool gnome-themes-standard python-pip python3-pip htop kate kompare chrome-gnome-shell \
	opam openjdk-8-jre lm-sensors synaptic gparted gimp inkscape nautilus-dropbox vlc texstudio texlive-full apt-file \
	python3-tk python-tk autoconf libtool cmake net-tools sshfs libopenmpi-dev npm libcanberra-gtk-module libcanberra-gtk3-module
	
	sudo apt-get autoremove
	sudo apt-get autoclean
	sudo apt-get clean

jupyter-conf:
	sudo -H pip3 install jupyter jupyterlab ipykernel pandas cobra escher seaborn bokeh nbopen dnaplotlib pysb testresources twine rise jupyter_contrib_nbextensions pillow
	sudo -H pip2 install jupyter jupyterlab ipykernel pandas cobra escher seaborn bokeh nbopen dnaplotlib pysb testresources twine rise jupyter_contrib_nbextensions pillow

	python3 -m nbopen.install_xdg
	python2 -m ipykernel install --user
	python3 -m ipykernel install --user

RISE-conf:
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

compile-python3:
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev \
	libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev
	
	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz
	tar xvzf Python-3.6.5.tgz
	cd Python-3.6.5
	make clean
	./configure --prefix=$HOME/python-3.6.5
	make
	make test
	make install

pip2-update:
	/usr/local/bin/pip2 list --outdated --format=columns | tail -n +3 | cut -d ' ' -f 1 | sudo -H xargs -n1 /usr/local/bin/pip2 install --upgrade

pip3-update:
	/usr/local/bin/pip3 list --outdated --format=columns | tail -n +3 | cut -d ' ' -f 1 | sudo -H xargs -n1 /usr/local/bin/pip3 install --upgrade

jupyter-autostart:
	echo 'python3 -m jupyter notebook --no-browser &' >> ~/.profile

git-clone:
	sudo chown -R glucksfall:glucksfall /opt
	git clone https://github.com/3DGenomes/TADbit.git /opt/git-3dgenomes-tadbit-master
	git clone https://github.com/Kappa-Dev/KaSim.git /opt/git-kappa.dev-kasim-master
	git clone https://github.com/Kappa-Dev/KaSim.git /opt/git-kappa.dev-kasim-kasim4 --branch KaSim4
	git clone https://github.com/Kappa-Dev/KaSim.git /opt/git-kappa.dev-kasim-kasim3 --branch KaSim3
	git clone https://github.com/sbmlteam/SBMLToolbox.git /opt/git-sbmlteam-sbmltoolbox-master
	git clone https://github.com/StochSS/StochKit.git /opt/git-stochss-stochkit-master
	git clone https://github.com/RuleWorld/bionetgen.git /opt/git-ruleworld-bionetgen-master
	git clone https://github.com/bmbolstad/RMAExpress.git /opt/git-bmbolstad-rmaexpress-master
	git clone https://github.com/bmbolstad/RMAExpress.git /opt/git-bmbolstad-rmaexpress-110 --branch RMAExpress_1_1_0
	git clone https://github.com/google/skicka.git /opt/git-google-skicka-master
	git clone https://github.com/naxo100/PISKa.git /opt/git-naxo100-piska-master
	git clone https://github.com/DLab/PISKaS.git /opt/git-dlab-piskas-master
	git clone https://github.com/opencobra/cobratoolbox.git /opt/git-opencobra-cobratoolbox-master
	git clone https://github.com/JuliaLang/IJulia.jl.git /opt/git-julialang-ijulia.jl-master
	git clone https://github.com/RuleWorld/rulebender.git /opt/git-ruleworld-rulebender-master
	git clone https://github.com/salilab/imp.git /opt/git-salilab-imp-master
	git clone https://github.com/hyattpd/Prodigal.git /opt/git-hyattpd-prodigal-master
	git clone https://github.com/RuleWorld/BioNetFit.git /opt/git-ruleworld-bionetfit-master
	git clone https://github.com/PosnerLab/BioNetFit.git /opt/git-posnerlab-bionetfit-master
	git clone https://github.com/ethereum/go-ethereum.git /opt/git-ethereum-goethereum-master
	git clone https://github.com/SysBioChalmers/RAVEN.git /opt/git-sysbiochalmers-raven-master
	git clone https://github.com/20n/act.git /opt/git-20n-act-master
	git clone https://github.com/CovertLab/WholeCellViz.git /opt/git-covertlab-wholecellviz-master
	git clone https://github.com/jhcepas/eggnog-mapper.git /opt/git-jhcepas-eggnog-mapper-master
	git clone https://github.com/borenstein-lab/CoMiDA.git /opt/git-borenstein-lab-comida-master
	git clone https://github.com/cryptoluka/CryptoLuKa.git /opt/git-cryptoluka-cryptoluka-master

mariadb-conf:
	sudo apt-get install mariadb-server
	sudo systemctl enable mysql
	sudo systemctl start mysql
	sudo mysql -u root
# 	create database slurm_acct_db;
# 	create user 'slurm'@'localhost';
# 	set password for 'slurm'@'localhost' = password('slurmdbpass');
# 	grant usage on *.* to 'slurm'@'localhost';
# 	grant all privileges on slurm_acct_db.* to 'slurm'@'localhost';
# 	flush privileges;
# 	exit

install-others:
	sudo dpkg -i /opt/ubuntu-software/gitter_3.1.0_amd64.deb
	sudo dpkg -i /opt/ubuntu-software/google-chrome-stable_current_amd64.deb
	sudo dpkg -i /opt/ubuntu-software/mendeleydesktop_1.17.13-stable_amd64.deb
	sudo dpkg -i /opt/ubuntu-software/prey_1.6.5_amd64.deb
	sudo dpkg -i /opt/ubuntu-software/snapgene_viewer_3.3.3_linux.deb
	#sudo dpkg -i /opt/ubuntu-software/whatsie-2.1.0-linux-amd64.deb
	sudo chown -R glucksfall:glucksfall /opt

	sudo apt-get install -f
	sudo apt-file update

	/opt/ubuntu-software/Anaconda3-5.1.0-Linux-x86_64.sh
	/opt/ubuntu-software/Cytoscape_3_5_1_unix.sh
	/opt/ubuntu-software/pathway-tools-21.0-linux-64-tier1-install

	tar xvzf /opt/ubuntu-software/gurobi7.5.2_linux64.tar.gz -C /opt
	tar xvzf /opt/ubuntu-software/COPASI-4.23.184-Linux-64bit.tar.gz -C /opt
	unzip /opt/ubuntu-software/matlab_R2017b_glnxa64.zip -d /opt/MATLAB

resume-network:
	sudo nano /etc/systemd/system/wifi-resume.service
	sudo systemctl enable wifi-resume.service
