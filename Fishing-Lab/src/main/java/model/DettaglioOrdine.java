package model;

public class DettaglioOrdine {
    private int idOrdine;
    private int idProdotto;
    private double prezzo_vendita;

    public DettaglioOrdine() {}

   
    public int getIdOrdine() { return idOrdine; }
    public void setIdOrdine(int idOrdine) { this.idOrdine = idOrdine; }
    public int getIdProdotto() { return idProdotto; }
    public void setIdProdotto(int idProdotto) { this.idProdotto = idProdotto; }
    public double getPrezzo_vendita() { return prezzo_vendita; }
    public void setPrezzo(double prezzo_vendita) { this.prezzo_vendita = prezzo_vendita; }
}