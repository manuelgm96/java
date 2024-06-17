import java.util.List;
import java.util.Iterator;
import java.util.stream.Stream;
import java.util.function.BiFunction;
import java.util.function.UnaryOperator;

public class DoubleCola {

    public static void main(String[] args) {
        String[] names = { "Sheldon", "Leonard", "Penny", "Rajesh", "Howard" };

        var seed = Stream.of(names)
                .map(name -> new Group(name, 1))
                .toList();

        UnaryOperator<List<Group>> f = (groups) -> groups.stream().map(doubleSize).toList();

        var groups = Stream.iterate(seed, f)
                .flatMap(List::stream)
                .iterator();

        System.out.println(nth.apply(1802, groups));

        return;
    }

    static final UnaryOperator<Group> doubleSize = group -> {
        group.setSize(group.getSize() * 2);
        return group;
    };

    static final BiFunction<Integer, Iterator<Group>, String> nth = (n, groups) -> {
        var g = groups.next();
        if (n <= g.getSize())
            return g.getName();
        else
            return DoubleCola.nth.apply(n - g.getSize(), groups);
    };
}
