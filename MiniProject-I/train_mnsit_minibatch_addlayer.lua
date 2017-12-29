-- Machine Learning II Midterm Project
-- Author: Dr. Amir Jafari and Dr. Martin Hagan
-- Edited By: Prince Birring
-- Mnsit datatset

require 'dp'
require 'cunn'
require 'optim'
require 'dpnn'

-- Load the mnist data set
ds = dp.Mnist()

-- Extract training, validation and test sets
trainInputs = ds:get('train', 'inputs', 'bchw')
trainTargets = ds:get('train', 'targets', 'b')
validInputs = ds:get('valid', 'inputs', 'bchw')
validTargets = ds:get('valid', 'targets', 'b')
testInputs = ds:get('test', 'inputs', 'bchw')
testTargets = ds:get('test', 'targets', 'b')

-- Create a two-layer network
module = nn.Sequential()
module:add(nn.Convert('bchw', 'bf')) -- collapse 3D to 1D
module:add(nn.Linear(1*28*28, 19))
module:add(nn.Tanh())
module:add(nn.Linear(19, 33))
module:add(nn.Tanh())
module:add(nn.Linear(33, 10))
module:add(nn.LogSoftMax())
module:cuda()

-- Use the cross-entropy performance index
criterion = nn.ClassNLLCriterion()
criterion:cuda()

torch.manualSeed(7)

-- allocate a confusion matrix
cm = optim.ConfusionMatrix(10)
-- create a function to compute 
function classEval(module, inputs, targets)
   cm:zero()
   for idx=1,inputs:size(1) do
      local input, target = inputs[idx], targets[idx]
      local output = module:forward(input)
      cm:add(output, target)
   end
   cm:updateValids()
   return cm.totalValid
end
 
function trainEpoch(module, criterion, inputs, targets, batch_size)
   for idx=0,(inputs:size(1) - batch_size), batch_size do
--local idx = math.random(1,inputs:size(1))
      local input= inputs[{{idx + 1, idx + batch_size}}] 
      
      local target = targets[{{idx + 1, idx + batch_size}}]
      -- forward
      local output = module:forward(input)
      local loss = criterion:forward(output, target)
      -- backward
      local gradOutput = criterion:backward(output, target)
      module:zeroGradParameters()
      local gradInput = module:backward(input, gradOutput)
      -- update
      module:updateGradParameters(0.9) -- momentum (dpnn)
      module:updateParameters(0.1) -- W = W - 0.1*dL/dW
   end
end

 bestAccuracy, bestEpoch = 0, 0
wait = 0
for epoch=1,30 do
   trainEpoch(module, criterion, trainInputs, trainTargets, 100)
   local validAccuracy = classEval(module, validInputs, validTargets)
   if validAccuracy > bestAccuracy then
      bestAccuracy, bestEpoch = validAccuracy, epoch
      --torch.save("/path/to/saved/model.t7", module)
      print(string.format("New maxima : %f @ %f", bestAccuracy, bestEpoch))
      wait = 0
   else
      wait = wait + 1
      if wait > 30 then break end
   end
end



testAccuracy = classEval(module, testInputs, testTargets)
print(string.format("Test Accuracy : %f ", testAccuracy))