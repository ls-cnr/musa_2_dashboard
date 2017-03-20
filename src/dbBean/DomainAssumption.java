package dbBean;

// Generated 1-mar-2017 16.50.58 by Hibernate Tools 3.4.0.CR1

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * DomainAssumption generated by hbm2java
 */
@Entity
@Table(name = "domain_assumption", catalog = "musa_db")
public class DomainAssumption implements java.io.Serializable {

	private Integer idAssumption;
	private Domain domain;
	private String name;
	private String assumption;
	private String description;

	public DomainAssumption() {
	}

	public DomainAssumption(Domain domain, String name, String assumption,
			String description) {
		this.domain = domain;
		this.name = name;
		this.assumption = assumption;
		this.description = description;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)
	@Column(name = "idAssumption", unique = true, nullable = false)
	public Integer getIdAssumption() {
		return this.idAssumption;
	}

	public void setIdAssumption(Integer idAssumption) {
		this.idAssumption = idAssumption;
	}

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "idDomain")
	public Domain getDomain() {
		return this.domain;
	}

	public void setDomain(Domain domain) {
		this.domain = domain;
	}

	@Column(name = "name", length = 45)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "assumption")
	public String getAssumption() {
		return this.assumption;
	}

	public void setAssumption(String assumption) {
		this.assumption = assumption;
	}

	@Column(name = "description")
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

}
