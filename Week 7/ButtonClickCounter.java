import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class ButtonClickCounter {
    private int count = 0;
    private JLabel label;

    public ButtonClickCounter() {
        JFrame frame = new JFrame("Button Click Counter");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(300, 150);
        frame.setLayout(new FlowLayout());

        JButton button = new JButton("Click Me!");
        label = new JLabel("Click count: 0");

        button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                count++;
                label.setText("Click count: " + count);
            }
        });

        frame.add(button);
        frame.add(label);
        frame.setVisible(true);
    }

    public static void main(String[] args) {
        new ButtonClickCounter();
    }
}
