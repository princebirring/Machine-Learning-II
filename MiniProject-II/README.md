# Training Convolution networks with Caffe on MNIST Dataset

The objective of this miniproject is to become familiar with Caffe for training deep convolution networks on large datasets.  You will be provided with a sample program that loadsin the MNIST data set and sets up an example convolution netwo
rk to be trained on it.  (See http://caffe.berkeleyvision.org/gathered/examples/mnist.html for a discussion of this example.) The instructions below provide a rough fra
mework of what you should do for the miniproject.  You should experiment with using Caffe on this large dataset.  The project is
open-ended. Learn as much as you can about using deep convolution networks, and relate what you have learned in your project report.  For all parts below,
and any other experiments you run, include the results into one PDF file, and upload it to the BlackBoard. Include all program listings, plots, command line printouts, discussion, etc.

1.  Download train_mnist.py, get_mnist.sh and create_mnist.sh from https://github.com/amir-jafari/Deep-Learning/tree/master/Caffe_/Mini_Project
and put them in the directory where you want to run your programs.
2.  Run the following commands on terminal in the your working path directory:
                
                 chmod   777 create_mnsit.sh   
                 chmod   777  get_mnsit.sh
                 . /getmnist.sh
               
3.  Open up the create_mnist.sh and change the path to of EXAMPLE and DATA to the directory that you are working with. Then run the following commands.<br/>
                     ./create_mnist.sh

4.  By this time you should have the train and test lmdb files of the mnist data set.
5.  Download lenet_solver.prototxt, lenet_train_test.prototxt from GitHub and put them in the directory.  Change the path of net in
lenet_solver.prototxt to your working path directory.
6.  Run  the  program train_mnist.py in  PyCharm  and  investigate and  verify  its  performance. You may need to change the line ”my
root =” to the appropriate path.
7.  Investigate the kernels in the two convolution layers. Can you identify kernels that would be useful for particular numerals?
8.  How does the performance of the convolution network compare with the multilayer networks that you used in MiniProject I?
9.  Change the size of the minibatches (batch_size parameter). If you make the batch size very large, does it affect the computation time significantly? Describe the advantages and disadvantages of increasing the batch size. Find a good choice.
10.  Use a  dropout layer  at layer fc1. Make fc1 the  top and  the bottom for  the  dropoutlayer. (See https://www.cs.toronto.edu/~hinton/absps/JMLRdropout.pdf for
a description of dropout.) Does dropout improve the testing error?
11.  Experiment with different numbers of layers and different numbers of kernels. Maintain the total number of weights and biases in the network, while increasing the number oflayers in the network.  Describe how the performance changes
as the number of layers increases – both in terms of training time and performance.
12.  Try one other training function from the list on this page: http://caffe.berkeleyvision.org/tutorial/solver.html. Compare the performance with gradient descent.
13. Note: Write a report and submit one pdf file with all of your finding, results, tables, codes and etc.  Also, you need to provide the code if you modify
it (any code or txt file or prototxtfile). Therefore, you nee
