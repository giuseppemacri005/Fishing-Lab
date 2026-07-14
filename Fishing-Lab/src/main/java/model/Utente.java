package model;

import java.io.Serializable;

public class Utente  implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id_utente;
    private String nome;
    private String cognome;
    private String email;
    private String password;
    private String ruolo;

 // Costruttore vuoto obbligatorio per lo standard JavaBean
    public Utente() {}

    // Metodi Getter e Setter per Utente
    public int getId_utente() { return id_utente; }
    public void setId_utente(int id_utente) { this.id_utente = id_utente; }

    public String getNome() { return nome; }
    public void setNome(String nome) { this.nome = nome; }

    public String getCognome() { return cognome; }
    public void setCognome(String cognome) { this.cognome = cognome; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRuolo() { return ruolo; }
    public void setRuolo(String ruolo) { this.ruolo = ruolo; }
    }