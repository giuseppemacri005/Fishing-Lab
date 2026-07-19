package model;

public class DettaglioOrdine {
    private int idOrdine;
    private int idProdotto;
    private double prezzo;

    public DettaglioOrdine() {}

   
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
}