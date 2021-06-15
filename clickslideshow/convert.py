import subprocess

folder = "/home/t/me/myprograms/ranscombe-websites/originalImages/slideshow"

def makeWebp(root):
    return root[:-4] + ".webp"

for root in os.listdir(folder):
    subprocess.run(
        ["cwebp", folder + "/" + root, "-o", makeWebp(root)])
