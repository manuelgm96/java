public class Group {

    public Group(String name, int size) {
        this.name = name;
        this.size = size;
    }

    String name;

    int size;

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getSize() {
        return this.size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public String toString() {
        return "Name: " + this.name + " Size: " + this.size;
    }
}
