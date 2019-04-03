#This is a Nipype generator. Warning, here be dragons.
#!/usr/bin/env python

import sys
import nipype
import nipype.pipeline as pe

import nipype.interfaces.fsl as fsl
import nipype.interfaces.io as io
import nipype.interfaces.afni as afni

#Wraps command **bet**
fsl_BET = pe.Node(interface = fsl.BET(), name='fsl_BET')

#Extension of DataGrabber module that downloads the file list and
io_SSHDataGrabber = pe.Node(interface = io.SSHDataGrabber(), name='io_SSHDataGrabber')

#Extension of DataGrabber module that downloads the file list and
io_SSHDataGrabber_1 = pe.Node(interface = io.SSHDataGrabber(), name='io_SSHDataGrabber_1')

#Wraps the executable command ``3dUnifize``.
afni_Unifize = pe.Node(interface = afni.Unifize(), name='afni_Unifize')

#Wraps the executable command ``3dDespike``.
afni_Despike = pe.Node(interface = afni.Despike(), name='afni_Despike')

#Wraps the executable command ``3dTshift``.
afni_TShift = pe.Node(interface = afni.TShift(), name='afni_TShift')

#Create a workflow to connect all those nodes
analysisflow = nipype.Workflow('MyWorkflow')


#Run the workflow
plugin = 'MultiProc' #adjust your desired plugin here
plugin_args = {'n_procs': 1} #adjust to your number of cores
analysisflow.write_graph(graph2use='flat', format='png', simple_form=False)
analysisflow.run(plugin=plugin, plugin_args=plugin_args)
