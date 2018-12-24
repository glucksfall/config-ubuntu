.ONESHELL:
test:
	echo $(HOME)
	echo $$(which pip3)

.ONESHELL:
apt-install:
	sudo apt update
	sudo apt -y upgrade
	sudo apt -y dist-upgrade
	sudo apt -y remove xul-ext-ubufox gedit

	APTS="gnome-tweak-tool gnome-themes-standard htop kate kompare \
	chrome-gnome-shell opam openjdk-8-jre lm-sensors synaptic gparted gimp \
	inkscape nautilus-dropbox vlc apt-file autoconf libtool cmake net-tools \
	sshfs libopenmpi-dev npm libcanberra-gtk-module libcanberra-gtk3-module \
	android-tools-adb android-tools-fastboot libgirepository1.0-dev \
	virtualbox curl gir1.2-gtop-2.0 gir1.2-networkmanager-1.0 \
	gir1.2-clutter-1.0 rar libreoffice r-base rename pandoc aptitude \
	sra-toolkit"

	for apt in $$APTS; do sudo apt -y install $$apt; done

	sudo apt -y autoremove
	sudo apt -y autoclean
	sudo apt -y clean

latex-install:
	sudo apt-get -y install texstudio texlive-full

export PYTHON3_PACKAGES=numpy pandas nose python-libsbml \
	cobra escher seaborn pillow bokeh dnaplotlib pysb \
	biopython openpyxl xlrd fastcluster scikit-bio \
	scikit-learn

export PYTHON2_PACKAGES=qiime

export DEV_PACKAGES=testresources twine sphinx sphinx-autobuild \
	sphinx_rtd_theme versioneer pylint autopep8

export CUDA_PYTHON3_PACKAGES=pycuda torchvision

export JUPYTER_PACKAGES=jupyter jupyterlab ipykernel nbopen rise

local-python-packages-install:
	~/bin/pip3 install $$PYTHON3_PACKAGES --upgrade

system-python-packages-install:
	sudo apt-get -y install python3-pip python3-tk python3-h5py

	sudo -H pip3 install $$PYTHON3_PACKAGES --upgrade
	sudo -H pip2 install $$PYTHON2_PACKAGES --upgrade

	# cython makes jupyter to crush; also weave (?)

cuda-and-python-packages-install:
	cd /opt/ubuntu-software

	sudo apt -y install linux-headers-$(uname -r)
	sudo dpkg -i cuda-repo-ubuntu1804-10-0-local-10.0.130-410.48_1.0-1_amd64.deb
	sudo apt-key add /var/cuda-repo-10-0-local-10.0.130-410.48/7fa2af80.pub
	sudo apt update
	sudo apt -y install cuda
	sudo apt -y install cuda-toolkit-10-0 cuda-tools-10-0 cuda-runtime-10-0 \
	cuda-compiler-10-0 cuda-libraries-10-0 cuda-libraries-dev-10-0 cuda-drivers


	sudo -H pip3 install http://download.pytorch.org/whl/cu100/torch-1.0.0-cp36-cp36m-linux_x86_64.whl
	sudo -H pip3 install $$CUDA_PYTHON3_PACKAGES --upgrade

devtools-python-packages-install:
	sudo -H pip3 install $$DEV_PACKAGES --upgrade
	sudo -H pip2 install $$DEV_PACKAGES --upgrade

jupyter-install:
	sudo -H pip3 install $$JUPYTER_PACKAGES --upgrade

	# install python3 kernel
	python3 -m ipykernel install --user
	python3 -m nbopen.install_xdg

	# install and enable rise
	sudo jupyter-nbextension install rise --py --sys-prefix
	sudo jupyter-nbextension enable rise --py --sys-prefix

# 	# install and enable contrib_nbextensions
# 	sudo jupyter-nbextension install jupyter_contrib_nbextensions --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_contrib_nbextensions --py --sys-prefix
#
# 	# install and enable nbextensions_configurator
# 	sudo jupyter-nbextension install jupyter_nbextensions_configurator --py --sys-prefix
# 	sudo jupyter-nbextension enable jupyter_nbextensions_configurator --py --sys-prefix
#
# 	# install and enable ipyparallel
# 	sudo jupyter-nbextension install --sys-prefix --py ipyparallel
# 	sudo jupyter-nbextension enable --sys-prefix --py ipyparallel
# 	sudo jupyter-serverextension enable --sys-prefix --py ipyparallel

kernels-jupyter:
	~/bin/R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'cran')"

	sudo R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), \
	repos = 'https://cloud.r-project.org/', dependencies = TRUE); \
	library(devtools); \
	devtools::install('/opt/github-repositories/IRkernel.IRkernel/R'); \
	library(IRkernel); \
	IRkernel::installspec(name = 'ir')"

.ONESHELL:
python3.6.5-compile:
	mkdir -p $(HOME)/opt/ubuntu-software

	sudo apt-get install build-essential checkinstall
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev

	wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tgz \
	-O $(HOME)/opt/ubuntu-software/Python-3.6.5.tgz
	if [ -d $(HOME)/opt/Python-3.6.5 ]; then rm -rf $(HOME)/opt/Python-3.6.5; fi
	tar xvzf $(HOME)/opt/ubuntu-software/Python-3.6.5.tgz -C $(HOME)/opt
	cd $(HOME)/opt/Python-3.6.5
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/python-3.6.5 ]; then rm -rf $(HOME)/opt/python-3.6.5; fi
	./configure --prefix=$(HOME)/opt/python-3.6.5 --enable-optimizations
	make
	make install

.ONESHELL:
python3.7.0-compile:
	mkdir -p $(HOME)/opt/ubuntu-software

	sudo apt-get install build-essential checkinstall
	sudo apt-get install libssl-dev zlib1g-dev libncurses5-dev \
	libncursesw5-dev libreadline-dev libsqlite3-dev libgdbm-dev \
	libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev tk-dev uuid-dev

	wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz \
	-O $(HOME)/opt/ubuntu-software/Python-3.7.0.tgz
	if [ -d $(HOME)/opt/Python-3.7.0 ]; then rm -rf $(HOME)/opt/Python-3.7.0; fi
	tar xvzf $(HOME)/opt/ubuntu-software/Python-3.7.0.tgz -C $(HOME)/opt
	cd $(HOME)/opt/Python-3.7.0
	if [ -f Makefile ]; then make clean; fi
	if [ -d $(HOME)/opt/python-3.7.0 ]; then rm -rf $(HOME)/opt/python-3.7.0; fi
	./configure --prefix=$(HOME)/opt/python-3.7.0 --enable-optimizations
	make
	make install

.ONESHELL:
r-3.5.0-compile:
	mkdir -p $(HOME)/opt/ubuntu-software

	sudo apt-get install libcairo2-dev libxt-dev libtiff5-dev libssh2-1-dev libxml2 libxml2-dev

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

local-r-packages-install:
	~/bin/R -e "install.packages('tidyverse', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('knitr', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('rmarkdown', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('gridExtra', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('plotly', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('Cairo', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('ggpubr', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('ape', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('biom', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('optparse', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('RColorBrewer', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('randomForest', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"
	~/bin/R -e "install.packages('vegan', \
	dependencies = TRUE, repos = 'https://cloud.r-project.org/')"

	# install bioConductor packages
	~/bin/R -e "source('https://bioconductor.org/biocLite.R'); \
	biocLite(); \
	biocLite('dada2'); \
	biocLite('edgeR'); \
	biocLite('phyloseq'); \
	biocLite('DESeq'); \
	biocLite('DESeq2'); \
	biocLite('microbiome'); \
	biocLite('metagenomeSeq')"

.ONESHELL:
github-clone-repositories:
	sudo chown -R $(USER):$(USER) /opt
	mkdir -p /opt/github-repositories

	GIT_REPOS=

	# clone
	git clone https://github.com/20n/act.git \
	/opt/github-repositories/20n.act

	git clone https://github.com/3DGenomes/TADbit.git \
	/opt/github-repositories/3DGenomes.TADbit

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/github-repositories/bmbolstad.RMAExpress_1_1_0 --branch RMAExpress_1_1_0

	git clone https://github.com/bmbolstad/RMAExpress.git \
	/opt/github-repositories/bmbolstad.RMAExpress

	git clone https://github.com/borenstein-lab/CoMiDA.git \
	/opt/github-repositories/borenstein-lab.CoMiDA

	git clone https://github.com/CovertLab/WholeCellViz.git \
	/opt/github-repositories/CovertLab.WholeCellViz

	git clone https://github.com/cryptoluka/CryptoLuKa.git \
	/opt/github-repositories/cryptoluka.CryptoLuKa

	git clone https://github.com/DLab/PISKaS.git \
	/opt/github-repositories/DLab.PISKaS

	git clone https://github.com/ethereum/go-ethereum.git \
	/opt/github-repositories/ethereum.go-ethereum

	git clone https://github.com/google/skicka.git \
	/opt/github-repositories/google.skicka

	git clone https://github.com/hyattpd/Prodigal.git \
	/opt/github-repositories/hyattpd.Prodigal

	git clone https://github.com/jhcepas/eggnog-mapper.git \
	/opt/github-repositories/jhcepas.eggnog-mapper

	git clone https://github.com/JuliaLang/IJulia.jl.git \
	/opt/github-repositories/JuliaLang.IJulia

	git clone https://github.com/IRkernel/IRkernel.git \
	/opt/github-repositories/IRkernel.IRkernel

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim3 --branch KaSim3

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim4 --branch KaSim4

	git clone https://github.com/Kappa-Dev/KaSim.git \
	/opt/github-repositories/Kappa-Dev.KaSim

	git clone https://github.com/naxo100/PISKa.git \
	/opt/github-repositories/naxo100.PISKa

	git clone https://github.com/opencobra/cobratoolbox.git \
	/opt/github-repositories/opencobra.cobratoolbox

	git clone https://github.com/PosnerLab/BioNetFit.git \
	/opt/github-repositories/PosnerLab.BioNetFit

	git clone https://github.com/RuleWorld/BioNetFit.git \
	/opt/github-repositories/RuleWorld.BioNetFit

	git clone https://github.com/RuleWorld/bionetgen.git \
	/opt/github-repositories/RuleWorld.bionetgen

	git clone https://github.com/RuleWorld/rulebender.git \
	/opt/github-repositories/RuleWorld.rulebender

	git clone https://github.com/salilab/imp.git \
	/opt/github-repositories/salilab.imp

	git clone https://github.com/sbmlteam/SBMLToolbox.git \
	/opt/github-repositories/sbmlteam.SBMLToolbox

	git clone https://github.com/SchedMD/slurm.git \
	/opt/github-repositories/SchedMD.slurm

	git clone https://github.com/StochSS/StochKit.git \
	/opt/github-repositories/StochSS.StochKit

	git clone https://github.com/SysBioChalmers/RAVEN.git \
	/opt/github-repositories/SysBioChalmers.RAVEN

	printf \
	"update-git:\n\tfor d in \`find . -maxdepth 1 -type d -not -name .\`; \
	do printf \'%%s\\\n\' "'"'"\$\$d\""; cd \$\$d; git pull; \
	git submodule init; git submodule update; printf \'\\\n\'; cd ..; done" \
	> /opt/github-repositories/Makefile

slurm-conf:
	sudo apt-get -y install slurm-wlm

	sudo mkdir -p /var/lib/slurm-llnl
	sudo mkdir -p /var/lib/slurm-llnl/slurmd
	sudo mkdir -p /var/lib/slurm-llnl/slurmctld
	sudo mkdir -p /var/run/slurm-llnl
	sudo mkdir -p /var/log/slurm-llnl

	sudo touch /var/log/slurm-llnl/slurmd.log
	sudo touch /var/log/slurm-llnl/slurmctld.log

	sudo chmod -R 755 /var/lib/slurm-llnl/
	sudo chmod -R 755 /var/run/slurm-llnl/
	sudo chmod -R 755 /var/log/slurm-llnl/

	sudo chown -R slurm:slurm /var/lib/slurm-llnl/
	sudo chown -R slurm:slurm /var/run/slurm-llnl/
	sudo chown -R slurm:slurm /var/log/slurm-llnl/

	sudo nano /etc/slurm-llnl/slurm.conf

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

.ONESHELL:
install-others:
	cd /opt/ubuntu-software/

	sudo dpkg -i gitter_3.1.0_amd64.deb
	sudo dpkg -i google-chrome-stable_current_amd64.deb
	sudo dpkg -i mendeleydesktop_1.17.13-stable_amd64.deb
	sudo dpkg -i prey_1.6.5_amd64.deb
	sudo dpkg -i snapgene_viewer_4.1.9_linux.deb
	sudo dpkg -i whatsie-2.1.0-linux-amd64.deb

	sudo chown -R $(USER):$(USER) /opt

	sudo apt-get install -f
	sudo apt-file update

	Anaconda3-5.1.0-Linux-x86_64.sh
	Cytoscape_3_5_1_unix.sh
	pathway-tools-21.0-linux-64-tier1-install

	tar xvzf gurobi7.5.2_linux64.tar.gz -C /opt
	tar xvzf COPASI-4.23.184-Linux-64bit.tar.gz -C /opt

.ONESHELL:
install-matlab:
	cd /opt/ubuntu-software/

	if [[ ! -d /opt/matlab_R2017b_glnxa64 ]]; \
	then unzip matlab_R2017b_glnxa64.zip -d /opt/matlab_R2017b_glnxa64; \
	fi

	cd /opt/matlab_R2017b_glnxa64
	install
