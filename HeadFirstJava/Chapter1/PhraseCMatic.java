public class PhraseCMatic {
	public static void main (String[] args) {
		String[] wordListOne = {"dynamic-program", "binary-tree", "splay-tree", "B-Tree", "greedy", "graph-theory", "Random-Alogrithm"};
		String[] wordListTwo = {"computer-scientist", "computer-networking", "Computer-System", "HeadFirstJava", "C++Primer", "Introduction-to-Algorihtms"};
		String[] wordListThree = {"csdn", "cnblog", "v2cx", "douban", "w3school", "coursera", "itercast"};

		int oneLength = wordListOne.length;
		int twoLength = wordListTwo.length;
		int threeLength = wordListThree.length;

		int rand1 = (int) (Math.random() * oneLength);
		int rand2 = (int) (Math.random() * twoLength);
		int rand3 = (int) (Math.random() * threeLength);

		String phrase = wordListOne[rand1] + " " + wordListTwo[rand2] + " " + wordListThree[rand3];

		System.out.println("What we need is a " + phrase);
	}
}
