apt-install:
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get dist-upgrade
	sudo apt-get remove xul-ext-ubufox gedit

	sudo apt-get -y install gnome-tweak-tool gnome-themes-standard \
	python-pip python3-pip htop kate kompare chrome-gnome-shell opam \
	openjdk-8-jre lm-sensors synaptic gparted gimp inkscape \
	nautilus-dropbox vlc texstudio texlive-full apt-file python3-tk \
	python-tk autoconf libtool cmake net-tools sshfs libopenmpi-dev npm \
	libcanberra-gtk-module libcanberra-gtk3-module android-tools-adb \
	android-tools-fastboot libgirepository1.0-dev virtualbox curl \
	gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 gir1.2-clutter-1.0 rar \
	libreoffice r-base rename pandoc

	sudo apt-get autoremove
	sudo apt-get autoclean
	sudo apt-get clean

install-python-packages-local:
	~/bin/python3 -c "import pip; pip.main(['install', 'pandas', \
	'cobra', 'escher', 'seaborn', 'pillow', 'bokeh', 'dnaplotlib', 'pysb', \
	'biopython', 'cython', ])"

install-python-packages-system:
	sudo -H python3 -c "import pip; pip.main(['install', 'pandas', \
	'cobra', 'escher', 'seaborn', 'pillow', 'bokeh', 'dnaplotlib', 'pysb', \
	'biopython', ])"

	sudo -H python2 -c "import pip; pip.main(['install', 'pandas', \
	'cobra', 'escher', 'seaborn', 'pillow', 'bokeh', 'dnaplotlib', 'pysb', \
	'biopython', ])"

	# cython makes jupyter crush, weave (?)

install-python-packages-developing:
	sudo -H python3 -c "import pip; pip.main(['install', 'testresources', \
	'twine', 'sphinx', 'sphinx-autobuild', 'sphinx_rtd_theme', \
	'versioneer', 'pylint', ])"

	sudo -H python2 -c "import pip; pip.main(['install', 'testresources', \
	'twine', 'sphinx', 'sphinx-autobuild', 'sphinx_rtd_theme', \
	'versioneer', 'pylint', ])"

conf-jupyter-system:
	sudo -H python3 -c "import pip; pip.main(['install', 'jupyter', \
	'jupyterlab', 'ipykernel', 'nbopen', 'rise', \
	'jupyter_contrib_nbextensions'])"

	sudo -H python2 -c "import pip; pip.main(['install', 'jupyter', \
	'jupyterlab', 'ipykernel', 'nbopen', 'rise', \
	'jupyter_contrib_nbextensions'])"

	python2 -m ipykernel install --user
	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

add-jupyter-kernels:
	~/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/'); \
	library(devtools); \
	devtools::install('/opt/git-irkernel-irkernel-master/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	sudo R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/'); \
	library(devtools); \
	devtools::install('/opt/git-irkernel-irkernel-master/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'ir')"

.ONESHELL:
install-python3.6-from-source:
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev \
	libcurl4-openssl-dev libzmq3-dev libssl-dev

	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz \
	-O $(HOME)/opt/ubuntu-software/Python-3.6.5.tgz
	if [ -d $(HOME)/opt/Python-3.6.5 ]; then rm -rf $(HOME)/opt/Python-3.6.5; fi
	tar xvzf $(HOME)/opt/ubuntu-software/Python-3.6.5.tgz -C ~/opt
	cd $(HOME)/opt/Python-3.6.5
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/python-3.6.5 ]; then rm -rf $(HOME)/opt/python-3.6.5; fi
	./configure --prefix=$(HOME)/opt/python-3.6.5 --enable-optimizations
	make
	make install

.ONESHELL:
install-python3.7-from-source:
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev

	wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz \
	-O $(HOME)/opt/ubuntu-software/Python-3.7.0.tgz
	if [ -d $(HOME)/opt/Python-3.7.0 ]; then rm -rf $(HOME)/opt/Python-3.7.0; fi
	tar xvzf $(HOME)/opt/ubuntu-software/Python-3.7.0.tgz -C ~/opt
	cd $(HOME)/opt/Python-3.7.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/python-3.7.0 ]; then rm -rf $(HOME)/opt/python-3.7.0; fi
	./configure --prefix=$(HOME)/opt/python-3.7.0 --enable-optimizations
	make
	make install

.ONESHELL:
install-r-3.5.0-from-source:
	sudo apt-get install libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml libxml2-dev
	wget https://cloud.r-project.org/bin/linux/ubuntu/bionic-cran35/r-base_3.5.0.orig.tar.gz \
	-O $(HOME)/opt/ubuntu-software/R-3.5.0.tgz
	if [ -d $(HOME)/opt/R-3.5.0 ]; then rm -rf $(HOME)/opt/R-3.5.0; fi
	tar xvzf $(HOME)/opt/ubuntu-software/R-3.5.0.tgz -C $(HOME)/opt
	cd $(HOME)/opt/R-3.5.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/r-3.5.0 ]; then rm -rf $(HOME)/opt/r-3.5.0; fi
	./configure --prefix=$(HOME)/opt/r-3.5.0 --enable-R-shlib --with-blas --with-lapack
	make
	make install

install-r-packages-local:
	~/bin/R -e "install.packages('tidyverse')"
	~/bin/R -e "install.packages('knitr')"
	~/bin/R -e "install.packages('rmarkdown')"
	~/bin/R -e "source("https://bioconductor.org/biocLite.R"); \
	biocLite(); \
	biocLite('dada2'); \
	biocLite('phyloseq')"

#update-pip3:
#	sudo -H python3 -c \
#	"import pip; pip.main(['install', '--upgrade', 'pip'])"

.ONESHELL:
update-python3-packages:
	$(which pip3) list --outdated --format=columns \
	| tail -n +3 | cut -d ' ' -f 1 | \
	sudo -H xargs -n1 $(which pip3) install --upgrade

#update-pip2:
#	sudo -H python2 -c \
#	"import pip; pip.main(['install', '--upgrade', 'pip'])"

.ONESHELL:
update-python2-packages:
	$(which pip) list --outdated --format=columns \
	| tail -n +3 | cut -d ' ' -f 1 | \
	sudo -H xargs -n1 $(which pip) install --upgrade

jupyter-autostart:
	echo 'python3 -m jupyter notebook --no-browser &' >> ~/.profile

git-clone:
	sudo chown -R glucksfall:glucksfall /opt

	git clone https://github.com/20n/act.git \
	/opt/git-20n-act-master

	git clone https://github.com/3DGenomes/TADbit.git \
	/opt/git-3dgenomes-tadbit-master

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/git-bmbolstad-rmaexpress-110 --branch RMAExpress_1_1_0

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/git-bmbolstad-rmaexpress-master

	git clone https://github.com/borenstein-lab/CoMiDA.git \
	/opt/git-borenstein-lab-comida-master

	git clone https://github.com/CovertLab/WholeCellViz.git \
	/opt/git-covertlab-wholecellviz-master

	git clone https://github.com/cryptoluka/CryptoLuKa.git \
	/opt/git-cryptoluka-cryptoluka-master

	git clone https://github.com/DLab/PISKaS.git \
	/opt/git-dlab-piskas-master

	git clone https://github.com/ethereum/go-ethereum.git \
	/opt/git-ethereum-goethereum-master

	git clone https://github.com/google/skicka.git \
	/opt/git-google-skicka-master

	git clone https://github.com/hyattpd/Prodigal.git \
	/opt/git-hyattpd-prodigal-master

	git clone https://github.com/jhcepas/eggnog-mapper.git \
	/opt/git-jhcepas-eggnog-mapper-master

	git clone https://github.com/JuliaLang/IJulia.jl.git \
	/opt/git-julialang-ijulia.jl-master

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/git-kappa.dev-kasim-kasim3 --branch KaSim3

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/git-kappa.dev-kasim-kasim4 --branch KaSim4

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/git-kappa.dev-kasim-master

	git clone https://github.com/naxo100/PISKa.git \
	/opt/git-naxo100-piska-master

	git clone https://github.com/opencobra/cobratoolbox.git \
	/opt/git-opencobra-cobratoolbox-master

	git clone https://github.com/PosnerLab/BioNetFit.git \
	/opt/git-posnerlab-bionetfit-master

	git clone https://github.com/RuleWorld/BioNetFit.git \
	/opt/git-ruleworld-bionetfit-master

	git clone https://github.com/RuleWorld/bionetgen.git \
	/opt/git-ruleworld-bionetgen-master

	git clone https://github.com/RuleWorld/rulebender.git \
	/opt/git-ruleworld-rulebender-master

	git clone https://github.com/salilab/imp.git \
	/opt/git-salilab-imp-master

	git clone https://github.com/sbmlteam/SBMLToolbox.git \
	/opt/git-sbmlteam-sbmltoolbox-master

	git clone https://github.com/SchedMD/slurm.git \
	/opt/git-schedmd-slurm-master

	git clone https://github.com/StochSS/StochKit.git \
	/opt/git-stochss-stochkit-master

	git clone https://github.com/SysBioChalmers/RAVEN.git \
	/opt/git-sysbiochalmers-raven-master

slurm-conf:
	sudo apt-get -y install slurm-wlm
	sudo nano /etc/slurm-llnl/slurm.conf

	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/
	sudo mkdir /var/spool/slurmd
	sudo chown -R slurm:slurm /var/spool/slurmd

#	sudo apt-get install mariadb-server
#	sudo systemctl enable mysql
#	sudo systemctl start mysql
#	sudo mysql -u root
# 	create database slurm_acct_db;
# 	create user 'slurm'@'localhost';
# 	set password for 'slurm'@'localhost' = password('slurmdbpass');
# 	grant usage on *.* to 'slurm'@'localhost';
# 	grant all privileges on slurm_acct_db.* to 'slurm'@'localhost';
# 	flush privileges;
# 	exit

gcp-conf:
	export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

	echo "deb https://packages.cloud.google.com/apt \
	$CLOUD_SDK_REPO main" | sudo tee -a \
	/etc/apt/sources.list.d/google-cloud-sdk.list

	curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
	| sudo apt-key add -

	sudo apt-get update
	sudo apt-get install google-cloud-sdk \
	google-cloud-sdk-app-engine-python \
	google-cloud-sdk-app-engine-python-extras \
	google-cloud-sdk-app-engine-java \
	google-cloud-sdk-app-engine-go \
	google-cloud-sdk-datalab \
	google-cloud-sdk-datastore-emulator \
	google-cloud-sdk-pubsub-emulator \
	google-cloud-sdk-cbt google-cloud-sdk-bigtable-emulator \
	kubectl

.ONESHELL:
gcp-uninstall:
	#gcloud info --format='value(installation.sdk_root)'
	sudo rm -r $(gcloud info --format='value(installation.sdk_root)')
	rm -r $(gcloud info --format='value(config.paths.global_config_dir)')

.ONESHELL:
install-others:
	cd /opt/ubuntu-software/

	if [[ ! -d /opt/Gitter ]]; then \
	sudo dpkg -i gitter_3.1.0_amd64.deb; \
	fi

	if [[ ! -d /opt/google/chrome ]]; then \
	sudo dpkg -i google-chrome-stable_current_amd64.deb; \
	fi

	if [[ ! -d /opt/mendeleydesktop ]]; then \
	sudo dpkg -i mendeleydesktop_1.17.13-stable_amd64.deb; \
	fi

	sudo dpkg -i prey_1.6.5_amd64.deb

	if [[ ! -d /opt/gslbiotech/snapgene-viewer ]]; then \
	sudo dpkg -i snapgene_viewer_4.1.9_linux.deb; \
	fi

	if [[ ! -d /opt/whatsie ]]; then \
	sudo dpkg -i whatsie-2.1.0-linux-amd64.deb; \
	fi

	sudo chown -R glucksfall:glucksfall /opt

	sudo apt-get install -f
	sudo apt-file update

	Anaconda3-5.1.0-Linux-x86_64.sh
	Cytoscape_3_5_1_unix.sh
	pathway-tools-21.0-linux-64-tier1-install

	tar xvzf gurobi7.5.2_linux64.tar.gz -C /opt
	tar xvzf COPASI-4.23.184-Linux-64bit.tar.gz -C /opt

	if [[ ! -d /opt/matlab_R2017b_glnxa64 ]]; \
	then unzip matlab_R2017b_glnxa64.zip -d /opt/matlab_R2017b_glnxa64; \
	fi
