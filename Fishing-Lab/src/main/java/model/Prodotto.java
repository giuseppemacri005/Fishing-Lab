package model;

import java.io.Serializable;

public class Prodotto implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id_prodotto;
    private String nome_prodotto;
    private String descrizione;
    private double prezzo;
    private String immagine;
    private String categoria;

    // Costruttore vuoto obbligatorio per lo standard JavaBean
    public Prodotto() {}

    // Metodi Getter e Setter
    public int getId_prodotto() { return id_prodotto; }
    public void setId_prodotto(int id_prodotto) { this.id_prodotto = id_prodotto; }

    public String getnome_prodotto() { return nome_prodotto; }
    public void setNome_prodotto(String nome_prodotto) { this.nome_prodotto = nome_prodotto; }

    public String getDescrizione() { return descrizione; }
    public void setDescrizione(String descrizione) { this.descrizione = descrizione; }

    public double getPrezzo() { return prezzo; }
    public void setPrezzo(double prezzo) { this.prezzo = prezzo; }
    
    public String getImmagine() { return this.immagine; }
    public void setImmagine(String immagine) { this.immagine = immagine; }
    
    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }
}