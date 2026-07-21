package model;

import java.util.Date;

public class Ordine {
    private int id_ordine;
    private int idUtente;
    private double totale;
    private Date data_ordine;
  
    private String indirizzo;
    private String numerocartapagamento; 

    public Ordine() {}

    public int getId_ordine() { return id_ordine; }
    public void setId_ordine(int id_ordine) { this.id_ordine = id_ordine; }
    
    public int getIdUtente() { return idUtente; }
    public void setIdUtente(int idUtente) { this.idUtente = idUtente; }
    
    public double getTotale() { return totale; }
    public void setTotale(double totale) { this.totale = totale; }
    
    public Date getData_ordine() { return data_ordine; }
    public void setData_ordine(Date data_ordine) { this.data_ordine = data_ordine; }
    
    
    
    public String getIndirizzo() { return indirizzo; }
    public void setIndirizzo(String indirizzo) { this.indirizzo = indirizzo; }

    public String getNumerocartapagamento() { return numerocartapagamento; }
    public void setNumerocartapagamento(String numerocartapagamento) { this.numerocartapagamento = numerocartapagamento; }
}