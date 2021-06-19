
import torch
import urllib
from PIL import Image
from torchvision import transforms
import matplotlib.pyplot as plt

class modelsetup:
	def __init__(self):
		self.model = torch.hub.load('pytorch/vision:v0.9.0', 'deeplabv3_resnet101', pretrained=True)
		self.model.eval()
		self.preprocess = transforms.Compose([
    		transforms.ToTensor(),
    		transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225]),
		])


	def usemodel(self,filename):
		input_image = Image.open(filename)
		input_tensor = self.preprocess(input_image)
		input_batch = input_tensor.unsqueeze(0) # create a mini-batch as expected by the model

		# move the input and model to GPU for speed if available
		if torch.cuda.is_available():
			input_batch = input_batch.to('cuda')
			self.model.to('cuda')
		
		with torch.no_grad():
			output = self.model(input_batch)['out'][0]
		output_predictions = output.argmax(0)	
		print(input_image.shape,input_tensor.shape,output_predictions.shape)
		return output_predictions

	def colseg(self,output_predictions):
		# create a color pallette, selecting a color for each class
		palette = torch.tensor([2 ** 25 - 1, 2 ** 15 - 1, 2 ** 21 - 1])
		colors = torch.as_tensor([i for i in range(21)])[:, None] * palette
		colors = (colors % 255).numpy().astype("uint8")
		#print(input_tensor.shape,output_predictions.shape)
		# plot the semantic segmentation predictions of 21 classes in each color
		r = Image.fromarray(output_predictions.byte().cpu().numpy()).resize(input_image.size)
		r.putpalette(colors)	
		return r


#url, filename = ("https://github.com/pytorch/hub/raw/master/images/dog.jpg", "dog.jpg")
#try: urllib.URLopener().retrieve(url, filename)
#except: urllib.request.urlretrieve(url, filename)
files = ['/home/manzil/Downloads/room4.jpeg','/home/manzil/Downloads/room5.jpeg','/home/manzil/Downloads/room6.jpeg']
print('setup the model')
m = modelsetup()
print('setup of model done...')

for fname in files:
	print(fname)
	i = m.usemodel(fname)
	r = m.colseg(i)
	plt.imshow(r)
	plt.show()
