// Question: https://www.codingame.com/ide/puzzle/defibrillators

import java.util.*;

class Pair<K,V> {
    private K key;
    private V value;

    public Pair(K key, V value){
        this.key = key;
        this.value = value;
    }

    public K getKey(){
        return this.key;
    }

    public V getValue(){
        return this.value;
    }
}

class Solution {

    public static void main(String args[]) {
        Scanner in = new Scanner(System.in);
        Double LNG = Math.toRadians(Double.parseDouble(in.next().replace(',', '.')));
        Double LAT = Math.toRadians(Double.parseDouble(in.next().replace(',', '.')));
        int N = in.nextInt();

        List<Pair<String, Double>> DEFIBS = new ArrayList<>();

        if (in.hasNextLine()) 
            in.nextLine();

        for (int i = 0; i < N; i++) {
            String s;
            String[] DEFIB = (s = in.nextLine()).split(";");
            Double lng = Math.toRadians(Double.parseDouble(DEFIB[4].replace(',', '.')));
            Double lat = Math.toRadians(Double.parseDouble(DEFIB[5].replace(',', '.')));
            
            Double x = (lng - LNG) * Math.cos((LAT + lat) / 2);
            Double y = lat - LAT;
            
            Double d = Math.sqrt(Math.pow(x, 2) + Math.pow(y, 2)) * 6371;         

            DEFIBS.add(new Pair<String, Double>(DEFIB[1],d));
        }

        Double minim = Double.MAX_VALUE;
        String name = "";

        for (Pair<String, Double> entry: DEFIBS){
            if (entry.getValue() < minim){
                minim = entry.getValue();
                name = entry.getKey();
            }
        }

        System.out.println(name);
    }
}